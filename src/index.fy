import './app.sass';
import app from "./app.fy";
import UserRouter from "./routers/userRouter.js";
import NovelRouter from "./routers/novelRouter.js";
import ChapterRouter from "./routers/chapterRouter.js";
import IndexRouter from "./routers/indexRouter.js";

// add router routes
app:router.route('/users', UserRouter);
app:router.route('/novels', NovelRouter);
app:router.route('/chapters', ChapterRouter);
app:router.route('/', IndexRouter);

// run router
app:router.run();
