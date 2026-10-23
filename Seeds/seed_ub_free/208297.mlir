module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<119> : tensor<4x1x7x2xi32>}> : () -> tensor<4x1x7x2xi32>
    %2 = "tosa.const"() <{values = dense<1.778300e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %3 = tosa.clamp %0 {max_val = 127 : i8, min_val = 45 : i8} : (tensor<i8>) -> tensor<i8>
    %4 = "tosa.const"() <{values = dense<[2, 3, 1, 0]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %5 = tosa.transpose %1 {perms = array<i32: 2, 3, 1, 0>} : (tensor<4x1x7x2xi32>) -> tensor<7x2x1x4xi32>
    %6 = tosa.exp %2 : (tensor<9xf32>) -> tensor<9xf32>
    %7 = tosa.clz %3 : (tensor<i8>) -> tensor<i8>
    %8 = tosa.exp %6 : (tensor<9xf32>) -> tensor<9xf32>
    // Output Inference: %6 (tensor<9xf32>) from tosa.exp %2 is exp(177.83). For f32, this overflows to Infinity.
    // UB Detection for tosa.pow: The "Operation requirement" for tosa.pow includes "REQUIRE(is_finite(value1) && is_finite(value2));".
    // Since %6 is Infinity, using it as an input to tosa.pow causes an undefined behavior.
    // Fix: Clamp %6 to the maximum finite f32 value.
    %c0 = "tosa.const"() <{values = dense<3.402823466e+38> : tensor<9xf32>}> : () -> tensor<9xf32>
    %a0 = tosa.minimum %6, %c0 : (tensor<9xf32>, tensor<9xf32>) -> tensor<9xf32>
    %9 = tosa.pow %a0, %a0 : (tensor<9xf32>, tensor<9xf32>) -> tensor<9xf32>
    %cast = tensor.cast %5 : tensor<7x2x1x4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<i8> to tensor<*xi8>
    %cast_1 = tensor.cast %8 : tensor<9xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %9 : tensor<9xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}