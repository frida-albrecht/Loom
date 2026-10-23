module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7xi1>}> : () -> tensor<7xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<7xi1>}> : () -> tensor<7xi1>
    %2 = "tosa.const"() <{values = dense<-1.164800e+02> : tensor<3x8x10xf32>}> : () -> tensor<3x8x10xf32>
    %3 = tosa.logical_xor %0, %1 : (tensor<7xi1>, tensor<7xi1>) -> tensor<7xi1>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<7xi1>) -> tensor<i32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %8 = tosa.sigmoid %2 : (tensor<3x8x10xf32>) -> tensor<3x8x10xf32>
    %9 = tosa.bitwise_and %7, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %10 = tosa.logical_left_shift %9, %9 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %11 = tosa.bitwise_or %10, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %a1 = "tosa.const"() <{values = dense<1> : tensor<i32>}> : () -> tensor<i32>
    %a2 = tosa.abs %10 : (tensor<i32>) -> tensor<i32>
    %a3 = tosa.maximum %a2, %a1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %12 = tosa.intdiv %11, %a3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %13 = tosa.log %8 : (tensor<3x8x10xf32>) -> tensor<3x8x10xf32>
    %14 = tosa.logical_right_shift %4, %9 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %15 = tosa.minimum %13, %8 : (tensor<3x8x10xf32>, tensor<3x8x10xf32>) -> tensor<3x8x10xf32>
    %cast = tensor.cast %12 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %14 : tensor<i32> to tensor<*xi32>
    %cast_1 = tensor.cast %15 : tensor<3x8x10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}