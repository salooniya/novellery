import { Router } from 'farmy';
import * as AppController from './controllers/app.fy';

// create router
const router = new Router();

// create router paths
router.path('/', AppController.home);
router.path('/~', AppController._404);

export default router as AppRouter;
