[[vk::push_constant]] uint* data;

[[vk::binding(0, 0)]] Sampler2D textures[];
[[vk::binding(0, 1)]] RWTexture2D targets[];

[shader("compute")] // Marks this as a compute shader
[numthreads(16,16,1)]
void main(uint2 global_thread_id: SV_DispatchThreadID, uint2 local_thread_id: SV_GroupThreadID ) {
	uint width, height;
    targets[0].GetDimensions(width, height);
    float2 size = float2(width, height);

	if(local_thread_id.x != 0 && local_thread_id.y != 0) {
		float4 pixel_color = float4(global_thread_id / size, 0, 1);
		targets[0][global_thread_id.xy] = pixel_color;
	}
}
