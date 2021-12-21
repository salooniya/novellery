import app from "../app.fy";

const fillDB = async function (collection, n, db) {
    for (let i = 0; i < n; i++) {
        await collection.create({
            title: `Title ${i}`,
            author: 'Syra Tinkr',
            likes: 1500 + i,
            subscribers: 250 + i,
            ratings: 4.7,
            genrePrimary: 'Romance',
            genreSecondary: 'Sci-fi'
        });
    }

    if (db) db.save();
};

export const getAll = async function () {
    return app:db.novels.data;
};

export const getOne = async function (ID) {
    const doc = await app:db.novels.get(ID);
    return doc;
};

export const post = async function (novel) {
    const doc = await app:db.novels.create(novel);
    app:db.novels.save();
    return doc;
};

export const putOne = async function (ID, novel) {
    const doc = await app:db.novels.update(ID, novel, true);
    app:db.novels.save();
    return doc;
};

export const patchOne = async function (ID, update) {
    const doc = await app:db.novels.update(ID, update, true);
    app:db.novels.save();
    return doc;
};

export const deleteOne = async function (ID) {
    const doc = await app:db.novels.delete(ID);
    app:db.novels.save();
    return doc;
};
