module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<30> : tensor<2x8x5xi32>}> : () -> tensor<2x8x5xi32>
    %1 = "tosa.const"() <{values = dense<-5.665000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<[3, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.tile %0, %2 : (tensor<2x8x5xi32>, !tosa.shape<3>) -> tensor<6x8x10xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = tosa.negate %3, %4, %5 : (tensor<6x8x10xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<6x8x10xi32>
    %7 = tosa.exp %1 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.reciprocal %7 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %6 : tensor<6x8x10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

