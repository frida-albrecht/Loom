module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<148> : tensor<2x2xi64>}> : () -> tensor<2x2xi64>
    %1 = "tosa.const"() <{values = dense<-7.576000e+01> : tensor<2x2xf32>}> : () -> tensor<2x2xf32>
    %2 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.reshape %0, %2 : (tensor<2x2xi64>, !tosa.shape<2>) -> tensor<2x2xi64>
    %4 = tosa.const_shape  {values = dense<[3, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.tile %3, %4 : (tensor<2x2xi64>, !tosa.shape<2>) -> tensor<6x4xi64>
    %6 = tosa.const_shape  {values = dense<[12, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.reshape %5, %6 : (tensor<6x4xi64>, !tosa.shape<3>) -> tensor<12x2x1xi64>
    %8 = tosa.reduce_max %7 {axis = 0 : i32} : (tensor<12x2x1xi64>) -> tensor<1x2x1xi64>
    %9 = tosa.log %1 : (tensor<2x2xf32>) -> tensor<2x2xf32>
    %10 = tosa.const_shape  {values = dense<[1, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %11 = tosa.reshape %8, %10 : (tensor<1x2x1xi64>, !tosa.shape<3>) -> tensor<1x2x1xi64>
    %cast = tensor.cast %9 : tensor<2x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<1x2x1xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

