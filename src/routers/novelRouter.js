import { Router } from "farmy";
import * as NovelController from "../controllers/novelController.fy";

const router = new Router();

router.path('/', NovelController.novels);
router.path('/:novelID', NovelController.novelByID);
router.path('/:novelID/chapters', NovelController.novelChapters);
router.path('/:novelID/chapters/:chapterID', NovelController.novelChapterByID);

export default router;
