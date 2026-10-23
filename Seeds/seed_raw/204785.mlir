module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<6x9x2xi64>}> : () -> tensor<6x9x2xi64>
    %1 = "tosa.const"() <{values = dense<-132> : tensor<1x9x2xi64>}> : () -> tensor<1x9x2xi64>
    %2 = tosa.logical_right_shift %0, %1 : (tensor<6x9x2xi64>, tensor<1x9x2xi64>) -> tensor<6x9x2xi64>
    %3 = tosa.reduce_sum %2 {axis = 0 : i32} : (tensor<6x9x2xi64>) -> tensor<1x9x2xi64>
    %4 = tosa.const_shape  {values = dense<[2, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.tile %3, %4 : (tensor<1x9x2xi64>, !tosa.shape<3>) -> tensor<2x9x4xi64>
    %cast = tensor.cast %5 : tensor<2x9x4xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

