import app from './app.fy';
import NovelRouter from './routers/novel';
import AppRouter from './routers/app';

// create router routes
app:router.route('/novels', NovelRouter);
app:router.route('/', AppRouter);

// run app router
app:router.run();
