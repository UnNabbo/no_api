[[vk::push_constant]] uint* data;

[SpecializationConstant]
const int myConst = 1; // Maps to a SPIRV specialization constant

[shader("compute")] // Marks this as a compute shader
[numthreads(1,1,1)]
void main() {
    uint x = *data;
	printf("%u", x);
}
