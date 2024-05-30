<script setup lang="ts">
import { ref, watch } from 'vue';
import { useWindowScroll } from '@vueuse/core';
const { y } = useWindowScroll();
const ScrollYStyle = ref('');
watch(y, (newVal) => {
  if (newVal !== 0) {
    ScrollYStyle.value = 'rgba(255, 255, 255, 0.9)';
  } else {
    ScrollYStyle.value = '';
  }
});
</script>

<template>
  <nav class="navbar fixed-top navbar-expand-lg" :style="{ 'background-color': ScrollYStyle }">
    <div class="container-fluid">
      <RouterLink to="/" class="me-3 navbar-brand text-info">
        <img src="../assets/image/logo.png" alt="logo" height="54" class="me-5" />
      </RouterLink>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNavDropdown"
        aria-controls="navbarNavDropdown"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
          <li class="nav-item me-3">
            <RouterLink to="" class="nav-link text-info">認識候選人</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="" class="nav-link text-info">最新活動</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="" class="nav-link text-info">政策議題</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="" class="nav-link text-info">小額捐款</RouterLink>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<style scoped>
.navbar {
  transition: all 0.3s ease-in;
}
.container-fluid {
  padding: 0 80px;
}
</style>
