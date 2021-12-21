import app from '../app.fy';
import * as NovelModel from '../models/novel.fy';

export const novels = async function () {
    const novels = await NovelModel.getAll();

    console.log(novels);
    app:root.innerHTML(`Novels`);
};

export const novelByID = async function (req) {
    const novelID = req.params.novelID;
    const novel = await NovelModel.getOne(novelID);

    console.log(novel);
    app:root.innerHTML(`Novel - ${novelID}`);
};

export const novelchapters = async function (req) {
    const novelID = req.params.novelID;

    app:root.innerHTML(`Novel - ${novelID} Chapters`);
};

export const novelchaptersByID = async function (req) {
    const novelID = req.params.novelID;
    const chapterID = req.params.chapterID;

    app:root.innerHTML(`Novel - ${novelID} Chapter - ${chapterID}`);
};
