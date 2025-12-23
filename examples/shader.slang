[[vk::binding(0, 0)]] Sampler2D textures[];
[[vk::binding(0, 1)]] RWTexture2D targets[];


struct Vertex {
	float3 position;
	float3 col;
	float2 uvs;
}
	


[[vk::push_constant]] Vertex* data;

struct VOut {
    float4 position : SV_Position;
	float3 col;
	float2 uvs;
}

[shader("vertex")]
VOut v_main(uint vertex_index : SV_VertexID) {
	VOut vout;
	printf("%f", data[0].position.y);
	printf("%u", vertex_index);
	vout.position = float4(data[vertex_index].position, 1);
	vout.uvs = data[vertex_index].uvs;
	vout.col = data[vertex_index].col;
	return vout;
}

[shader("fragment")] // Marks this as a compute shader
float4 f_main(VOut input) : SV_Target {
	let texture = textures[0];
    let color = texture.Sample(input.uvs) * float4(input.col, 1);
	return color;
}
