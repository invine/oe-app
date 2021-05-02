<template>
  <div class="container">
    <div class="d-grid gap-2 p-2">
      <button class="btn btn-outline-link" v-on:click="addExtParam">
        Add Extended Parameter
      </button>
    </div>
    <ul class="list-goup px-1">
      <li
        class="list-group item"
        v-for="(extParam, index) in extParams"
        v-bind:key="index"
      >
        <ext-param
          :extParam="extParam"
          v-on:removeExtParam="removeExtParam($event)"
        />
      </li>
    </ul>
  </div>
</template>

<script>
import ExtParam from "./ExtParam.vue";
export default {
  components: { ExtParam },
  name: "ExtParams",
  props: {
    extParams: Array,
  },
  methods: {
    addExtParam: function () {
      this.extParams.push({ name: "", value: "" });
    },
    removeExtParam: function (ep) {
      this.extParams.splice(this.extParams.indexOf(ep), 1);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>