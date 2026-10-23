module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8> : tensor<1x7x3x8xi32>}> : () -> tensor<1x7x3x8xi32>
    %1 = "tosa.const"() <{values = dense<-141> : tensor<1x7x3x8xi32>}> : () -> tensor<1x7x3x8xi32>
    %2 = "tosa.const"() <{values = dense<-6.998000e+01> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<1.692000e+02> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.minimum %0, %1 : (tensor<1x7x3x8xi32>, tensor<1x7x3x8xi32>) -> tensor<1x7x3x8xi32>
    %5 = tosa.intdiv %4, %4 : (tensor<1x7x3x8xi32>, tensor<1x7x3x8xi32>) -> tensor<1x7x3x8xi32>
    %6 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<1x7x3x8xi32>) -> tensor<1x7x1x8xi32>
    %c0_f32 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %safe_pow_base = tosa.maximum %2, %c0_f32 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %7 = tosa.pow %safe_pow_base, %3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %8 = tosa.add %6, %6 : (tensor<1x7x1x8xi32>, tensor<1x7x1x8xi32>) -> tensor<1x7x1x8xi32>
    %9 = tosa.const_shape  {values = dense<[3, 2, 2, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %10 = tosa.tile %8, %9 : (tensor<1x7x1x8xi32>, !tosa.shape<4>) -> tensor<3x14x2x8xi32>
    %11 = tosa.reverse %10 {axis = 1 : i32} : (tensor<3x14x2x8xi32>) -> tensor<3x14x2x8xi32>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<3x14x2x8xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}