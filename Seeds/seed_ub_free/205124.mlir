module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<28> : tensor<3x8xi64>}> : () -> tensor<3x8xi64>
    %1 = "tosa.const"() <{values = dense<1.659200e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reverse %0 {axis = 1 : i32} : (tensor<3x8xi64>) -> tensor<3x8xi64>
    %3 = tosa.bitwise_and %2, %2 : (tensor<3x8xi64>, tensor<3x8xi64>) -> tensor<3x8xi64>
    %4 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.tile %3, %4 : (tensor<3x8xi64>, !tosa.shape<2>) -> tensor<6x24xi64>
    %6 = tosa.reduce_product %5 {axis = 1 : i32} : (tensor<6x24xi64>) -> tensor<6x1xi64>
    %7 = tosa.exp %1 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.tanh %7 : (tensor<f32>) -> tensor<f32>
    %9 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.tile %3, %9 : (tensor<3x8xi64>, !tosa.shape<2>) -> tensor<9x24xi64>
    %11 = tosa.concat %10, %10 {axis = 0 : i32} : (tensor<9x24xi64>, tensor<9x24xi64>) -> tensor<18x24xi64>
    %12 = tosa.minimum %10, %10 : (tensor<9x24xi64>, tensor<9x24xi64>) -> tensor<9x24xi64>
    %13 = tosa.concat %5, %5 {axis = 0 : i32} : (tensor<6x24xi64>, tensor<6x24xi64>) -> tensor<12x24xi64>
    %14 = tosa.reciprocal %7 : (tensor<f32>) -> tensor<f32>
    %15 = tosa.argmax %10 {axis = 1 : i32} : (tensor<9x24xi64>) -> tensor<9xi32>
    %cast = tensor.cast %6 : tensor<6x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<18x24xi64> to tensor<*xi64>
    %cast_2 = tensor.cast %12 : tensor<9x24xi64> to tensor<*xi64>
    %cast_3 = tensor.cast %13 : tensor<12x24xi64> to tensor<*xi64>
    %cast_4 = tensor.cast %14 : tensor<f32> to tensor<*xf32>
    %cast_5 = tensor.cast %15 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_2) : (tensor<*xi64>) -> ()
    call @printMemrefI64(%cast_3) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_4) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_5) : (tensor<*xi32>) -> ()
    return
  }
}

