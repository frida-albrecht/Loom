module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8.769000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-134> : tensor<10x10xi64>}> : () -> tensor<10x10xi64>
    %2 = "tosa.const"() <{values = dense<true> : tensor<5xi1>}> : () -> tensor<5xi1>
    %3 = "tosa.const"() <{values = dense<true> : tensor<1xi1>}> : () -> tensor<1xi1>
    %4 = tosa.rsqrt %0 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.reciprocal %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reduce_sum %1 {axis = 0 : i32} : (tensor<10x10xi64>) -> tensor<1x10xi64>
    %7 = tosa.logical_xor %2, %3 : (tensor<5xi1>, tensor<1xi1>) -> tensor<5xi1>
    %8 = tosa.argmax %7 {axis = 0 : i32} : (tensor<5xi1>) -> tensor<i32>
    %9 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.tile %6, %9 : (tensor<1x10xi64>, !tosa.shape<2>) -> tensor<3x10xi64>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<i32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<3x10xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}

