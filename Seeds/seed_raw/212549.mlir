module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-116> : tensor<4x3xi64>}> : () -> tensor<4x3xi64>
    %1 = "tosa.const"() <{values = dense<1.352300e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<4x3xi64>) -> tensor<3xi32>
    %3 = tosa.bitwise_not %2 : (tensor<3xi32>) -> tensor<3xi32>
    %4 = tosa.sub %3, %2 : (tensor<3xi32>, tensor<3xi32>) -> tensor<3xi32>
    %5 = tosa.ceil %1 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.ceil %5 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %8 = tosa.reshape %6, %7 : (tensor<f32>, !tosa.shape<4>) -> tensor<1x1x1x1xf32>
    %9 = tosa.rsqrt %8 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %10 = tosa.bitwise_xor %3, %2 : (tensor<3xi32>, tensor<3xi32>) -> tensor<3xi32>
    %cast = tensor.cast %4 : tensor<3xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<1x1x1x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<3xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

