import { createApp } from 'vue';
import App from './App.vue';
import router from './router'; // Import your Vue Router configuration if using
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap';

const app = createApp(App);

// Optionally, use Vue Router
app.use(router);

app.mount('#app');
