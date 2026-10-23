module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<108> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<9.875000e+01> : tensor<5x8xf32>}> : () -> tensor<5x8xf32>
    %2 = tosa.abs %0 : (tensor<i64>) -> tensor<i64>
    %3 = tosa.abs %2 : (tensor<i64>) -> tensor<i64>
    %4 = tosa.rsqrt %1 : (tensor<5x8xf32>) -> tensor<5x8xf32>
    %5 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %6 = tosa.tile %4, %5 : (tensor<5x8xf32>, !tosa.shape<2>) -> tensor<15x8xf32>
    %7 = tosa.reverse %4 {axis = 1 : i32} : (tensor<5x8xf32>) -> tensor<5x8xf32>
    %cast = tensor.cast %3 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %6 : tensor<15x8xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %7 : tensor<5x8xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

