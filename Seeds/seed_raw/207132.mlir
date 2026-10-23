module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.392300e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-59> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<12> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<32> : tensor<6x6x7x4xi64>}> : () -> tensor<6x6x7x4xi64>
    %4 = "tosa.const"() <{values = dense<-166> : tensor<6x20x7x4xi64>}> : () -> tensor<6x20x7x4xi64>
    %5 = tosa.sigmoid %0 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.exp %5 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.bitwise_or %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %8 = tosa.concat %3, %4 {axis = 1 : i32} : (tensor<6x6x7x4xi64>, tensor<6x20x7x4xi64>) -> tensor<6x26x7x4xi64>
    %9 = tosa.sigmoid %6 : (tensor<f32>) -> tensor<f32>
    %10 = tosa.arithmetic_right_shift %7, %7 {round = true} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %11 = tosa.minimum %8, %8 : (tensor<6x26x7x4xi64>, tensor<6x26x7x4xi64>) -> tensor<6x26x7x4xi64>
    %cast = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<i32> to tensor<*xi32>
    %cast_1 = tensor.cast %11 : tensor<6x26x7x4xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_1) : (tensor<*xi64>) -> ()
    return
  }
}

