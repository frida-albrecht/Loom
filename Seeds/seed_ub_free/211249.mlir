module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<77> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<153> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<11> : tensor<5x7x5xi64>}> : () -> tensor<5x7x5xi64>
    %3 = "tosa.const"() <{values = dense<147> : tensor<5x7x20xi64>}> : () -> tensor<5x7x20xi64>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<i32>}> : () -> tensor<i32>
    %a1 = tosa.maximum %1, %c0 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %a2 = tosa.minimum %a1, %c31 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %4 = tosa.arithmetic_right_shift %0, %a2 {round = true} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.concat %2, %3 {axis = 2 : i32} : (tensor<5x7x5xi64>, tensor<5x7x20xi64>) -> tensor<5x7x25xi64>
    %6 = tosa.const_shape  {values = dense<[2, 2, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.tile %5, %6 : (tensor<5x7x25xi64>, !tosa.shape<3>) -> tensor<10x14x75xi64>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<10x14x75xi64> to tensor<*xi64>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}