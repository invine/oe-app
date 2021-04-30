<template>
  <div class="ext-param">
    <input placeholder="Extended Parameter" v-model="extParam.name" />
    <input placeholder="Value" v-model="extParam.value" />
    <button v-on:click="removeExtParam" >x</button>
  </div>
</template>

<script>
export default {
  name: "ExtParam",
  props: {
    extParam: Object,
  },
  methods: {
    removeExtParam: function() {
      this.$emit("removeExtParam", this.extParam)
    }
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.ext-param {
  padding: 10px;
  margin: 0;
  background: white;
  border: 1px;
}
h2 {
  color: gray;
}
</style>