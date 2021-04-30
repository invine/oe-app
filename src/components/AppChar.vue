<template>
  <div class="characteristic">
    <span class="char-name">{{ char.name }}</span>
    <select v-if="isList" v-model="char.value[0]">
      <option />
      <option v-for="v in values" v-bind:key="v.value">
        {{ v.value }}
      </option>
    </select>
    <input :placeholder="valueType" v-if="!isList" v-model="char.value[0]" />
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
.characteristic {
  padding: 10px;
  margin: 0;
  background: purple;
  color: white;
}

.char-name {
  color: white;
  margin-left: 10px;
  margin-right: 10px;
}
</style>