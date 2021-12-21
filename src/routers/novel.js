import { Router } from 'farmy';
import * as NovelController from '../controllers/novel.fy';

// create router
const router = new Router();

// create router paths
router.path('/', NovelController.novels);
router.path('/:novelID', NovelController.novelByID);
router.path('/:novelID/chapters', NovelController.novelchapters);
router.path('/:novelID/chapters/:chapterID', NovelController.novelchaptersByID);

export default router;
