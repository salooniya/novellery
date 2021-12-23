import { View } from 'farmy';
import app from '../app.fy';
import * as NovelModel from '../models/novelModel.fy';
import * as UserModel from '../models/userModel.fy';

const headerView = new View(/*html*/`
    <header>
        <h1><a href="/">[appName]</a></h1>
        <nav>
            [user-nav-1]
            [user-nav-2]
        </nav>
    </header>
`);

const usersView = new View(/*html*/`
    ${headerView.template}
    <section class="users-view">
        <h2>👥 [h2-title]</h2>
        <hr>
        <div class="list">
            [users]
            (<div class="list-item">
                <h3><a href="/users/[ID]">[ID]</a></h3>
                <p>username: [username]</p>
                <p>fullname: [fullname]</p>
                <p>email: [email]</p>
                <p>password: [password]</p>
                <p>gender: [gender]</p>
                <p>createdNovelsID: [createdNovelsID]</p>
                <p>subscribedNovelsID: [subscribedNovelsID]</p>
            </div>)
        </div>
    </section>
`);

export const users = async function () {
    const user = await app:db.index.get('user');
    const users = await UserModel.getAll();
    console.log(users);

    const view = usersView.get({
        appName: app:name,
        'h2-title': 'Users',
        'user-nav-1': user ? `<a href="/users/${user.ID}">🙍‍♂️ USER</a>` : `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': user ? `` : `<a href="/login">😃 LOGIN</a>`,
        users
    });
    app:root.innerHTML(view);
};

const userView = new View(/*html*/`
    ${headerView.template}
    <section class="user-view">
        <h2>👤 [username]</h2>
        <hr>
        <div class="text-box">
            <p>📛 [fullname]</p>
            <p>📧 [email]</p>
            <p>🚻 [gender]</p>
        </div>
        <h2>📚 Subscribed Novels</h2>
        <hr>
        <div class="text-box">
            [subscribedNovels]
            (<a href="/novels/[ID]">📘 [title]</a><br>)
        </div>
        <h2>📚 Created Novels</h2>
        <hr>
        <div class="text-box">
            [createdNovels]
            (<a href="/novels/[ID]">📘 [title]</a><br>)
        </div>
    </section>
`);

export const userByID = async function (req) {
    const loggedUser = await app:db.index.get('user');
    if (!loggedUser) {
        app:router.run(`/login`)
        history.replaceState(null, null, `/login`);
        return;
    }
    const user = await UserModel.getOne(req.params.userID);
    if (loggedUser.ID !== user.ID) {
        app:router.run(`/lost`);
        return;
    }
    console.log(user);

    const subscribedNovels = [];
    for (const novelID of user.subscribedNovelsID) {
        let novel = await NovelModel.getOne(novelID);
        subscribedNovels.push(novel);
    }

    const createdNovels = [];
    for (const novelID of user.createdNovelsID) {
        let novel = await NovelModel.getOne(novelID);
        createdNovels.push(novel);
    }

    const view = userView.get({
        appName: app:name,
        'user-nav-1': ``,
        'user-nav-2': `<a href="/logout">😕 LOGOUT</a>`,
        subscribedNovels,
        createdNovels,
        ... user
    });
    app:root.innerHTML(view);
};

const authorsView = new View(/*html*/`
    ${headerView.template}
    <section class="authors-view">
        <h2>👥 [h2-title]</h2>
        <hr>
        <div class="list">
            [users]
            (<div class="list-item">
                <h3><a href="/authors/[ID]">[ID]</a></h3>
                <p>username: [username]</p>
                <p>fullname: [fullname]</p>
                <p>createdNovelsID: [createdNovelsID]</p>
            </div>)
        </div>
    </section>
`);

export const authors = async function () {
    const user = await app:db.index.get('user');
    const users = await UserModel.getAll();

    const view = authorsView.get({
        appName: app:name,
        'h2-title': 'Authors',
        'user-nav-1': user ? `<a href="/users/${user.ID}">🙍‍♂️ USER</a>` : `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': user ? `` : `<a href="/login">😃 LOGIN</a>`,
        users
    });
    app:root.innerHTML(view);
};

const authorView = new View(/*html*/`
    ${headerView.template}
    <section class="author-view">
        <h2>✍ [username]</h2>
        <hr>
        <div class="text-box">
            <p>📛 [fullname]</p>
            <p>📧 [email]</p>
        </div>
        <h2>📚 Created Novels</h2>
        <hr>
        <div class="text-box">
            [createdNovels]
            (<a href="/novels/[ID]">📘 [title]</a><br>)
        </div>
    </section>
`);

export const authorByID = async function (req) {
    const user = await app:db.index.get('user');
    const author = await UserModel.getOne(req.params.userID);

    const createdNovels = [];
    for (const novelID of author.createdNovelsID) {
        let novel = await NovelModel.getOne(novelID);
        createdNovels.push(novel);
    }

    const view = authorView.get({
        appName: app:name,
        'user-nav-1': user ? `<a href="/users/${user.ID}">🙍‍♂️ USER</a>` : `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': user ? `` : `<a href="/login">😃 LOGIN</a>`,
        createdNovels,
        ... author
    });
    app:root.innerHTML(view);
};
