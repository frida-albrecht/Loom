module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.500000e-01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = "tosa.const"() <{values = dense<-64> : tensor<6x5xi64>}> : () -> tensor<6x5xi64>
    %2 = "tosa.const"() <{values = dense<-141> : tensor<6x5xi64>}> : () -> tensor<6x5xi64>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.transpose %0 {perms = array<i32: 0>} : (tensor<7xf32>) -> tensor<7xf32>
    %5 = tosa.logical_left_shift %1, %2 : (tensor<6x5xi64>, tensor<6x5xi64>) -> tensor<6x5xi64>
    %6 = tosa.bitwise_not %5 : (tensor<6x5xi64>) -> tensor<6x5xi64>
    %7 = tosa.clz %5 : (tensor<6x5xi64>) -> tensor<6x5xi64>
    %8 = tosa.abs %6 : (tensor<6x5xi64>) -> tensor<6x5xi64>
    %9 = tosa.clz %8 : (tensor<6x5xi64>) -> tensor<6x5xi64>
    %10 = tosa.argmax %9 {axis = 1 : i32} : (tensor<6x5xi64>) -> tensor<6xi32>
    %11 = tosa.clz %7 : (tensor<6x5xi64>) -> tensor<6x5xi64>
    %12 = tosa.const_shape  {values = dense<[2, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %13 = tosa.tile %11, %12 : (tensor<6x5xi64>, !tosa.shape<2>) -> tensor<12x5xi64>
    %14 = tosa.const_shape  {values = dense<[2, 3]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %15 = tosa.reshape %10, %14 : (tensor<6xi32>, !tosa.shape<2>) -> tensor<2x3xi32>
    %cast = tensor.cast %4 : tensor<7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %13 : tensor<12x5xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %15 : tensor<2x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

