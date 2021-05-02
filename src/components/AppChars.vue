<template>
  <!-- <div v-if="hasChars"> -->
  <div v-if="chars.length > 0">
    <div class="text-center">Characteristics</div>
    <ul class="group-list ps-1">
      <li class="group-list-item" v-for="char in chars" v-bind:key="char.name">
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
</style>