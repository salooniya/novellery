import { View } from 'farmy';
import app from '../app.fy';
import * as UserModel from '../models/userModel.fy';

const headerView = new View(/*html*/`
    <header>
        <h1><a href="/">[appName]</a></h1>
        <nav>
            <a href="/login">😃 LOGIN</a>
            <a href="/signup">😄 SIGNUP</a>
        </nav>
    </header>
`);

const usersView = new View(/*html*/`
    ${headerView.template}
    <section class="users-view">
        <h2>👥 Users</h2>
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
    const users = await UserModel.getAll();
    console.log(users);

    const view = usersView.get({
        appName: app:name,
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
            <p>✍ [createdNovelsID]</p>
            <p>📚 [subscribedNovelsID]</p>
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

    const view = userView.get({
        appName: app:name,
        ... user
    });
    app:root.innerHTML(view);
};
