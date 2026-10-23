module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<96> : tensor<5xi64>}> : () -> tensor<5xi64>
    %1 = "tosa.const"() <{values = dense<-1.513600e+02> : tensor<2x4x7x8xf32>}> : () -> tensor<2x4x7x8xf32>
    %2 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %0, %2 : (tensor<5xi64>, !tosa.shape<1>) -> tensor<15xi64>
    %4 = tosa.bitwise_xor %3, %3 : (tensor<15xi64>, tensor<15xi64>) -> tensor<15xi64>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = tosa.transpose %4 {perms = array<i32: 0>} : (tensor<15xi64>) -> tensor<15xi64>
    %7 = tosa.identity %6 : (tensor<15xi64>) -> tensor<15xi64>
    %8 = tosa.tanh %1 : (tensor<2x4x7x8xf32>) -> tensor<2x4x7x8xf32>
    %cast = tensor.cast %7 : tensor<15xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %8 : tensor<2x4x7x8xf32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

