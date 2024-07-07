<template>
  <div class="hello">
    <div class="p-4"></div>
    <h1 class="pt-4 mt-4">{{ msg }}</h1>
    <div class="p-4"></div>

    <div class="row mt-4 p-4">
      <div class="col-md-6 mt-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Posts</h5>
            <p class="card-text">Manage and view posts</p>
            <router-link to="/posts" class="btn btn-dark">Go to Posts</router-link>
          </div>
        </div>
      </div>

      <div class="col-md-6 mt-4">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Users</h5>
            <p class="card-text">Manage and view users</p>
            <router-link to="/users" class="btn btn-dark">Go to Users</router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  }
}
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}

.btn-dark, .btn-outline-dark {
  background-color: #343a40;
  color: #fff;
  border: none;
}

.btn-outline-dark:hover {
  background-color: #23272b;
  color: #fff;
}
</style>
