import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import VueDragSelect from "@coleqiu/vue-drag-select";

const app = createApp(App)

app.use(VueDragSelect);
app.use(router)

app.mount('#app')
