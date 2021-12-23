import { Router } from "farmy";
import * as ChapterController from "../controllers/chapterController.fy";

const router = new Router();

router.path('/', ChapterController.chapters);
router.path('/:chapterID', ChapterController.chapterByID);

export default router;
