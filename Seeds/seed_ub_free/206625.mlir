module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-120> : tensor<7x5x4x2xi32>}> : () -> tensor<7x5x4x2xi32>
    %1 = "tosa.const"() <{values = dense<-53> : tensor<1x5x4x2xi32>}> : () -> tensor<1x5x4x2xi32>
    %2 = "tosa.const"() <{values = dense<-1.988300e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-7.541000e+01> : tensor<f32>}> : () -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<1x5x4x2xi32>}> : () -> tensor<1x5x4x2xi32>
    %t0 = tosa.maximum %1, %c0 : (tensor<1x5x4x2xi32>, tensor<1x5x4x2xi32>) -> tensor<1x5x4x2xi32>
    %c1 = "tosa.const"() <{values = dense<31> : tensor<1x5x4x2xi32>}> : () -> tensor<1x5x4x2xi32>
    %t1 = tosa.minimum %t0, %c1 : (tensor<1x5x4x2xi32>, tensor<1x5x4x2xi32>) -> tensor<1x5x4x2xi32>
    %4 = tosa.arithmetic_right_shift %0, %t1 {round = true} : (tensor<7x5x4x2xi32>, tensor<1x5x4x2xi32>) -> tensor<7x5x4x2xi32>
    %c2 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %t2 = tosa.maximum %2, %c2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %c3 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %t3 = tosa.maximum %3, %c3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.pow %t2, %t3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %6 = tosa.bitwise_not %4 : (tensor<7x5x4x2xi32>) -> tensor<7x5x4x2xi32>
    %7 = tosa.abs %6 : (tensor<7x5x4x2xi32>) -> tensor<7x5x4x2xi32>
    %8 = tosa.reduce_sum %7 {axis = 3 : i32} : (tensor<7x5x4x2xi32>) -> tensor<7x5x4x1xi32>
    %cast = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<7x5x4x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}