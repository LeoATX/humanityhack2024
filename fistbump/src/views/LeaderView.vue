<script>

export default {
    name: "MainView",
    components: {
        MainNavbar,
    },
    data: () => {
        return {
            "options": options
        }
    }
};
</script>

<template>
    <div style="display: grid; gridTemplateColumns: 2fr 5fr;">
        <div style="grid-column: 1; background: white; height: 100vh">
            <drag-select v-model="selection">
                <drag-select-option v-for="item in options" :value="item" :key="item">⠀</drag-select-option>
            </drag-select>
        </div>
        <div style="grid-column: 2; background: white; height: 100vh; overflow-y: auto; overflow-x: hidden">
            <MainNavbar />

            <p style="font-size: 500px">Sigma</p>
            <p style="font-size: 500px">Sigma</p>
            <p style="font-size: 500px">Sigma</p>
        </div>
    </div>
</template>

<style></style>
