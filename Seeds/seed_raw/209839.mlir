module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-30> : tensor<10xi16>}> : () -> tensor<10xi16>
    %1 = "tosa.const"() <{values = dense<1.292400e+02> : tensor<1x9x6x5xf32>}> : () -> tensor<1x9x6x5xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<10xi16>) -> tensor<1xi16>
    %3 = tosa.const_shape  {values = dense<0> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.slice %2, %3, %4 : (tensor<1xi16>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<1xi16>
    %6 = tosa.tanh %1 : (tensor<1x9x6x5xf32>) -> tensor<1x9x6x5xf32>
    %7 = tosa.concat %6, %6 {axis = 0 : i32} : (tensor<1x9x6x5xf32>, tensor<1x9x6x5xf32>) -> tensor<2x9x6x5xf32>
    %cast = tensor.cast %5 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<2x9x6x5xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

