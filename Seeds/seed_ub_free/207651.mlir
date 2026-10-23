module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<0> : tensor<4x9xi64>}> : () -> tensor<4x9xi64>
    %1 = "tosa.const"() <{values = dense<81> : tensor<4x1xi64>}> : () -> tensor<4x1xi64>
    %2 = "tosa.const"() <{values = dense<1.999500e+02> : tensor<9x1xf32>}> : () -> tensor<9x1xf32>
    %3 = "tosa.const"() <{values = dense<-5.392000e+01> : tensor<9x1xf32>}> : () -> tensor<9x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x1xi64>}> : () -> tensor<4x1xi64>
    %tmp1 = tosa.maximum %1, %c0 : (tensor<4x1xi64>, tensor<4x1xi64>) -> tensor<4x1xi64>
    %c1 = "tosa.const"() <{values = dense<63> : tensor<4x1xi64>}> : () -> tensor<4x1xi64>
    %tmp2 = tosa.minimum %tmp1, %c1 : (tensor<4x1xi64>, tensor<4x1xi64>) -> tensor<4x1xi64>
    %4 = tosa.arithmetic_right_shift %0, %tmp2 {round = false} : (tensor<4x9xi64>, tensor<4x1xi64>) -> tensor<4x9xi64>
    %5 = tosa.pow %2, %3 : (tensor<9x1xf32>, tensor<9x1xf32>) -> tensor<9x1xf32>
    %6 = tosa.bitwise_not %4 : (tensor<4x9xi64>) -> tensor<4x9xi64>
    %7 = "tosa.const"() <{values = dense<[1, 0]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %8 = tosa.transpose %5 {perms = array<i32: 1, 0>} : (tensor<9x1xf32>) -> tensor<1x9xf32>
    %cast = tensor.cast %6 : tensor<4x9xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %8 : tensor<1x9xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}