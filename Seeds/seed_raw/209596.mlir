module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<7x10x4x10xi8>}> : () -> tensor<7x10x4x10xi8>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1x10x4x10xi8>}> : () -> tensor<1x10x4x10xi8>
    %2 = "tosa.const"() <{values = dense<1.140000e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.sub %0, %1 : (tensor<7x10x4x10xi8>, tensor<1x10x4x10xi8>) -> tensor<7x10x4x10xi8>
    %4 = tosa.reduce_min %3 {axis = 3 : i32} : (tensor<7x10x4x10xi8>) -> tensor<7x10x4x1xi8>
    %5 = tosa.clamp %4 {max_val = 3 : i8, min_val = -24 : i8} : (tensor<7x10x4x1xi8>) -> tensor<7x10x4x1xi8>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<7x10x4x1xi8>) -> tensor<7x10x4x1xi8>
    %7 = tosa.reduce_sum %6 {axis = 2 : i32} : (tensor<7x10x4x1xi8>) -> tensor<7x10x1x1xi8>
    %8 = tosa.reciprocal %2 : (tensor<f32>) -> tensor<f32>
    %9 = tosa.clz %7 : (tensor<7x10x1x1xi8>) -> tensor<7x10x1x1xi8>
    %10 = tosa.bitwise_not %9 : (tensor<7x10x1x1xi8>) -> tensor<7x10x1x1xi8>
    %11 = tosa.minimum %10, %9 : (tensor<7x10x1x1xi8>, tensor<7x10x1x1xi8>) -> tensor<7x10x1x1xi8>
    %12 = tosa.bitwise_or %11, %10 : (tensor<7x10x1x1xi8>, tensor<7x10x1x1xi8>) -> tensor<7x10x1x1xi8>
    %13 = tosa.reciprocal %8 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %12 : tensor<7x10x1x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %13 : tensor<f32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

