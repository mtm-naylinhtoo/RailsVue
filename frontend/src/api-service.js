import axios from 'axios';

const axiosInstance = axios.create({
  baseURL: 'http://localhost:3000/', // Update with your Rails API base URL
});

axiosInstance.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  error => Promise.reject(error)
);

export const apiService = {
  login(email, password) {
    return axiosInstance.post('/login', {
      user: { email, password }
    });
  },
  signup(userData) {
    return axiosInstance.post('/signup', {
      user: userData
    });
  },
  getPosts() {
    return axiosInstance.get('/posts');
  },

  getUsers() {
    return axiosInstance.get('/users');
  },

  getUser(userID) {
    return axiosInstance.get(`/users/${userID}`);
  },

  deletePost(postID) {
    return axiosInstance.delete(`/posts/${postID}`);
  },

  deleteUser(userID) {
    return axiosInstance.delete(`/users/${userID}`);
  },

  getPost(postID) {
    return axiosInstance.get(`/posts/${postID}`);
  },


  createPost(postData) {
    return axiosInstance.post('/posts', { post: postData });
  },

  updatePost(postID, postData) {
    return axiosInstance.put(`/posts/${postID}`, postData);
  },

  updateUser(userID, userData) {
    return axiosInstance.put(`/users/${userID}`, userData);
  },


};

export default apiService;
