<template>
  <div class="ext-params">
    <h3 v-if="drawExtParam">Extended Parameters</h3>
    <ul>
      <li v-for="(extParam, index) in extParams" v-bind:key="index">
        <ext-param
          :extParam="extParam"
          v-on:removeExtParam="removeExtParam($event)"
        />
      </li>
    </ul>
    <button v-on:click="addExtParam">Add Extended Parameter</button>
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
  computed: {
    drawExtParam: function () {
      return this.extParams && this.extParams.length > 0;
    },
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
.ext-params {
  padding: 10px;
  margin: 0;
  background: rgb(34, 187, 166);
  border: 1px;
}
h3 {
  color: rgb(235, 235, 235);
}
</style>