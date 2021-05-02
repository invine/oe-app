<template>
  <div class="row">
    <div class="col-4">
      <div class="text-start">
        {{ char.name }}
      </div>
    </div>
    <div class="col-7">
      <select class="form-select" v-if="isList" v-model="char.value[0]">
        <option />
        <option v-for="v in values" v-bind:key="v.value">
          {{ v.value }}
        </option>
      </select>
      <input
        class="form-control"
        :placeholder="valueType"
        v-if="!isList"
        v-model="char.value[0]"
      />
    </div>
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
</style>