const mongoose = require("mongoose");
const Story = mongoose.model("Story");
const User = mongoose.model("User");
const multer = require("multer");
const jimp = require("jimp");
const uuid = require("uuid");

const multerOptions = {
  storage: multer.memoryStorage(),
  fileFilter(req, file, next) {
    const isPhoto = file.mimetype.startsWith("image/");
    if (isPhoto) {
      next(null, true);
    } else {
      next({ message: "That filetype isn't allowed!" }, false);
    }
  }
};

//exports
exports.homePage = (req, res) => {
  // res.render("index"); // Here base page linking
};

exports.addStory = (req, res) => {
  //Here attach the add Story flutter link
  //res.render("editStory", { title: "Add Story" });
};

//Uploading Images using multer and resizing using jimp
exports.upload = multer(multerOptions).single("photo");

exports.resize = async (req, res, next) => {
  // check if there is no new file to resize
  if (!req.file) {
    next(); // skip to the next middleware
    return;
  }
  const extension = req.file.mimetype.split("/")[1];
  req.body.photo = `${uuid.v4()}.${extension}`;
  // now we resize
  const photo = await jimp.read(req.file.buffer);
  //HERE 800 is the size of image and you can adjust it by self
  await photo.resize(800, jimp.AUTO);
  await photo.write(`./public/uploads/${req.body.photo}`);
  // once we have written the photo to our filesystem, keep going!
  next();
};

exports.createStory = async (req, res) => {
  req.body.author = req.user._id;
  const Story = await new Story(req.body).save();
  // req.flash(
  //   "success",
  //   `Successfully Created ${Story.name}. Care to leave a review?`
  // );
  // routing related to story by flutter
  // res.redirect(`/Story/${Story.slug}`);
};

exports.getStorys = async (req, res) => {
  const page = req.params.page || 1;
  const limit = 4;
  const skip = page * limit - limit;

  // 1. Query the database for a list of all Storys
  const StorysPromise = Story.find()
    .skip(skip)
    .limit(limit)
    .sort({ created: "desc" });

  const countPromise = Story.count();

  const [Storys, count] = await Promise.all([StorysPromise, countPromise]);
  const pages = Math.ceil(count / limit);
  if (!Storys.length && skip) {
    // req.flash(
    //   "info",
    //   `Hey! You asked for page ${page}. But that doesn't exist. So I put you on page ${pages}`
    // );
    res.redirect(`/Storys/page/${pages}`);
    return;
  }
  //Rendering story using flutter
  // res.render("Storys", { title: "Storys", Storys, page, pages, count });
};

const confirmOwner = (Story, user) => {
  if (!Story.author.equals(user._id)) {
    throw Error("You must own a Story in order to edit it!");
  }
};

exports.editStory = async (req, res) => {
  // 1. Find the Story given the ID
  const Story = await Story.findOne({ _id: req.params.id });
  // 2. confirm they are the owner of the Story
  confirmOwner(Story, req.user);
  // 3. Render out the edit form so the user can update their Story
  res.render("editStory", { title: `Edit ${Story.name}`, Story });
};

exports.updateStory = async (req, res) => {
  // set the location data to be a point
  req.body.location.type = "Point";
  // find and update the Story
  const Story = await Story.findOneAndUpdate({ _id: req.params.id }, req.body, {
    new: true, // return the new Story instead of the old one
    runValidators: true
  }).exec();
  req.flash(
    "success",
    `Successfully updated <strong>${Story.name}</strong>. <a href="/Storys/${Story.slug}">View Story →</a>`
  );
  res.redirect(`/Storys/${Story._id}/edit`);
  // Redriect them the Story and tell them it worked
};

exports.getStoryBySlug = async (req, res, next) => {
  const Story = await Story.findOne({ slug: req.params.slug }).populate(
    "author reviews"
  );
  if (!Story) return next();
  res.render("Story", { Story, title: Story.name });
};

exports.getStorysByTag = async (req, res) => {
  const tag = req.params.tag;
  const tagQuery = tag || { $exists: true, $ne: [] };

  const tagsPromise = Story.getTagsList();
  const StorysPromise = Story.find({ tags: tagQuery });
  const [tags, Storys] = await Promise.all([tagsPromise, StorysPromise]);

  res.render("tag", { tags, title: "Tags", tag, Storys });
};

exports.searchStorys = async (req, res) => {
  const Storys = await Story
    // first find Storys that match
    .find(
      {
        $text: {
          $search: req.query.q
        }
      },
      {
        score: { $meta: "textScore" }
      }
    )
    // the sort them
    .sort({
      score: { $meta: "textScore" }
    })
    // limit to only 5 results
    .limit(5);
  res.json(Storys);
};
