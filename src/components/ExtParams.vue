<template>
  <div>
    <div class="box" v-if="drawExtParam">
      <div class="block">
        <span class="subtitle">Extended Parameters</span>
      </div>
      <div class="block">
        <ul>
          <li
            class="block"
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
    </div>
    <button class="button is-primary is-small" v-on:click="addExtParam">
      Add Extended Parameter
    </button>
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
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>