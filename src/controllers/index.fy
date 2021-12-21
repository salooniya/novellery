import app from '../app.fy';

export const home = async () => {
    app:root.innerHTML(`Home`);
};

export const _404_ = async () => {
    app:root.innerHTML(`404 - ${location.pathname}`);
};

