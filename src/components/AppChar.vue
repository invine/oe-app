<template>
  <div class="columns">
    <div class="label column block">{{ char.name }}</div>
    <select class="input column block" v-if="isList" v-model="char.value[0]">
      <option />
      <option v-for="v in values" v-bind:key="v.value">
        {{ v.value }}
      </option>
    </select>
    <input
      class="input column block"
      :placeholder="valueType"
      v-if="!isList"
      v-model="char.value[0]"
    />
  </div>
</template>

<script>
export default {
  name: "AppChar",
  props: {
    char: Object,
    valueType: String,
    values: Array,
  },
  computed: {
    isList: function () {
      return this.values && this.values.length > 0;
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.2/css/bulma.min.css";
</style>