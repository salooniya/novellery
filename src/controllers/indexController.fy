import { View, $, Router } from 'farmy';
import app from '../app.fy';
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

const homeView = new View(/*html*/`
    ${headerView.template}
    <section class="home-view">
        <h2>Collections</h2>
        <hr>
        <nav>
            <a href="/users">👥 Users</a>
            <a href="/novels">📚 Novels</a>
            <a href="/chapters">📖 Chapters</a>
        </nav>
    </section>
`);

export const home = async function () {
    const user = await app:db.index.get('user');
    console.log(user);

    const view = homeView.get({
        appName: app:name,
        'user-nav-1': user ? `<a href="/users/${user.ID}">🙍‍♂️ USER</a>` : `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': user ? `<a href="/logout">😕 LOGOUT</a>` : `<a href="/login">😃 LOGIN</a>`
    });
    app:root.innerHTML(view);
};

const signupView = new View(/*html*/`
    ${headerView.template}
    <section class="signup-view">
        <h2>Signup</h2>
        <hr>
        <form>
            <div>
                <label for="username">Username:</label><br>
                <input id="username" type="text" placeholder="Mikeee" />
            </div>
            <div>
                <label for="fullname">Fullname:</label><br>
                <input id="fullname" type="text" placeholder="Mike Tylor" />
            </div>
            <div>
                <label for="email">Email:</label><br>
                <input id="email" type="email" placeholder="miketylor@gmail.com" />
            </div>
            <div>
                <label for="password">Password:</label><br>
                <input id="password" type="password" placeholder="******" />
            </div>
            <div>
                <label for="confirm-password">Confirm Password:</label><br>
                <input id="confirm-password" type="password" placeholder="******" />
            </div>
            <div>
                <label for="gender">Gender:</label><br>
                <select id="gender">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>
            </div><br>
            <div>
                <input id="agree" type="checkbox" />
                <label for="agree">I read and agree to <a href="terms-and-conditions">Terms and Conditions</a></label>
            </div>
            <button type="submit">Signup</button>
        </form>
    </section>
`);

export const signup = async function () {
    const user = await app:db.index.get('user');
    if (user) {
        app:router.run(`/users/${user.ID}`)
        history.replaceState(null, null, `/users/${user.ID}`); 
        return;
    }

    const view = signupView.get({
        appName: app:name,
        'user-nav-1': `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': `<a href="/login">😃 LOGIN</a>`
    });
    app:root.innerHTML(view);
};

const loginView = new View(/*html*/`
    ${headerView.template}
    <section class="login-view">
        <h2>Login</h2>
        <hr>
        <form>
            <div>
                <label for="username">Username:</label><br>
                <input id="username" type="text" placeholder="Mikeee" />
            </div>
            <div>
                <label for="password">Password:</label><br>
                <input id="password" type="password" placeholder="******" />
            </div>
            <br>
            <div>
                <input id="remember" type="checkbox" />
                <label for="remember">Remember me</label>
            </div>
            <button type="submit">Login</button>
        </form>
    </section>
`);

export const login = async function () {
    const user = await app:db.index.get('user');
    if (user) {
        app:router.run(`/users/${user.ID}`)
        history.replaceState(null, null, `/users/${user.ID}`);
        return;
    }
    
    const view = loginView.get({
        appName: app:name,
        'user-nav-1': `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': `<a href="/login">😃 LOGIN</a>`
    });
    app:root.innerHTML(view);

    const $loginViewForm = $('section.login-view form');

    $loginViewForm.on('submit', async (e) => {
        e.preventDefault();
        const username = $loginViewForm.$('#username').value();
        const password = $loginViewForm.$('#password').value();
        const rememberCheck = $loginViewForm.$('#remember').el.checked;
        
        const user = await UserModel.login(username, password);
        if (user) {
            app:router.run('/')
            history.replaceState(null, null, '/');
        }
    });

};

const logoutView = new View(/*html*/`
    ${headerView.template}
    <section class="logout-view">
        <h2>Logging out ...</h2>
        <hr>
    </section>
`);

export const logout = async function () {
    const view = logoutView.get({
        appName: app:name,
        'user-nav-1': ``,
        'user-nav-2': ``
    });
    app:root.innerHTML(view);

    await UserModel.logout();
    app:router.run(`/`)
    history.replaceState(null, null, `/`);
};

const lostView = new View(/*html*/`
    ${headerView.template}
    <section class="lost-view">
        <h2>404</h2>
        <hr>
    </section>
`);


export const lost = async function () {
    const view = lostView.get({
        appName: app:name
    });
    app:root.innerHTML(view);
};
