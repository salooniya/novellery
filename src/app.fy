import { State, Router, Component, View, $ } from 'farmy';
import router from './router.fy';

// create app state
const app = new State();

// initialization 
let String app:title = undefined;
let String app:description = undefined;
const Router app:router = router;

// actions
app::title @ updateTitle = () => { $.title( app:title ) };
app::description @ updateDescription = () => { $.description( app:description ) };

// declaration
app:title = 'Novellery';
app:description = 'A web app to read what you love';

// run app router
app:router.run();
