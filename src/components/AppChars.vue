<template>
  <!-- <div v-if="hasChars"> -->
  <div class="box" v-if="chars.length > 0">
    <div class="block">Characteristics</div>
    <ul class="block">
      <li v-for="char in chars" v-bind:key="char.name">
        <app-char
          :char="char"
          :spec="getSpec(char)"
          :valueType="getSpec(char) | valueType"
          :values="getSpec(char) | values"
        />
      </li>
    </ul>
  </div>
</template>

<script>
import AppChar from "./AppChar.vue";

export default {
  name: "AppChars",
  components: { AppChar },
  props: {
    chars: Array,
    specs: Array,
  },
  filters: {
    valueType: function (spec) {
      return spec.valueType;
    },
    values: function (spec) {
      return spec.entitySpecCharacteristicValue || [];
    },
  },
  methods: {
    getSpec: function (char) {
      return this.specs.find((el) => el.name == char.name);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>