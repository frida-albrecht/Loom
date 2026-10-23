module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.479900e+02> : tensor<4x3x8xf32>}> : () -> tensor<4x3x8xf32>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<10xi8>}> : () -> tensor<10xi8>
    %2 = "tosa.const"() <{values = dense<1> : tensor<10xi8>}> : () -> tensor<10xi8>
    %3 = tosa.rsqrt %0 : (tensor<4x3x8xf32>) -> tensor<4x3x8xf32>
    %4 = tosa.reduce_min %3 {axis = 1 : i32} : (tensor<4x3x8xf32>) -> tensor<4x1x8xf32>
    %5 = tosa.minimum %4, %4 : (tensor<4x1x8xf32>, tensor<4x1x8xf32>) -> tensor<4x1x8xf32>
    %6 = tosa.logical_left_shift %1, %2 : (tensor<10xi8>, tensor<10xi8>) -> tensor<10xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<10xi8>}> : () -> tensor<10xi8>
    %clamped_lower = tosa.maximum %6, %c0 : (tensor<10xi8>, tensor<10xi8>) -> tensor<10xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<10xi8>}> : () -> tensor<10xi8>
    %clamped_shift = tosa.minimum %clamped_lower, %c7 : (tensor<10xi8>, tensor<10xi8>) -> tensor<10xi8>
    %7 = tosa.logical_left_shift %6, %clamped_shift : (tensor<10xi8>, tensor<10xi8>) -> tensor<10xi8>
    %8 = tosa.identity %6 : (tensor<10xi8>) -> tensor<10xi8>
    %cast = tensor.cast %5 : tensor<4x1x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<10xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %8 : tensor<10xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}