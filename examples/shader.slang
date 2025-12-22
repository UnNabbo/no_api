[[vk::push_constant]] uint* data;

[[vk::binding(0, 0)]] Sampler2D textures[];
[[vk::binding(1, 0)]] RWTexture2D targets[];

[shader("vertex")] // Marks this as a compute shader
void v_main() {

}

[shader("fragment")] // Marks this as a compute shader
void f_main() {

}
