[[vk::push_constant]] uint* data;

[[vk::binding(0, 0)]] Sampler2D textures[];
[[vk::binding(1, 0)]] RWTexture2D targets[];

[shader("compute")] // Marks this as a compute shader
[numthreads(1,1,1)]
void main(uint3 thread_id: SV_GroupThreadID) {
	int2 texel_coord = int2(thread_id.xy);
	uint width, height;

    textures[0].GetDimensions(width, height);
    int2 size = int2(width, height);

	if (texel_coord.x >= size.x || texel_coord.y >= size.y)
        return;
    
    
    // Calculate blend and write
    float blend = float(texel_coord.y) / float(size.y);
    float4 pixel_color = lerp(float4(1,0,0,1), float4(0,0,1,1), blend);
}
