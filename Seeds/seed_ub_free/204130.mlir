module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-146> : tensor<9x9xi32>}> : () -> tensor<9x9xi32>
    %1 = "tosa.const"() <{values = dense<1.449300e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.const_shape  {values = dense<[5, 0]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.const_shape  {values = dense<[4, 9]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.slice %0, %2, %3 : (tensor<9x9xi32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<4x9xi32>
    %5 = tosa.const_shape  {values = dense<[1, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.const_shape  {values = dense<[3, 4]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.slice %4, %5, %6 : (tensor<4x9xi32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<3x4xi32>
    %8 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %9 = tosa.transpose %7 {perms = array<i32: 0, 1>} : (tensor<3x4xi32>) -> tensor<3x4xi32>
    %10 = tosa.ceil %1 : (tensor<f32>) -> tensor<f32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<3x4xi32>}> : () -> tensor<3x4xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<3x4xi32>}> : () -> tensor<3x4xi32>
    %s1 = tosa.maximum %7, %c0 : (tensor<3x4xi32>, tensor<3x4xi32>) -> tensor<3x4xi32>
    %s2 = tosa.minimum %s1, %c31 : (tensor<3x4xi32>, tensor<3x4xi32>) -> tensor<3x4xi32>
    %11 = tosa.arithmetic_right_shift %9, %s2 {round = false} : (tensor<3x4xi32>, tensor<3x4xi32>) -> tensor<3x4xi32>
    %cast = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<3x4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}