module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<43> : tensor<8x4x6xi16>}> : () -> tensor<8x4x6xi16>
    %1 = "tosa.const"() <{values = dense<-1.030900e+02> : tensor<6x4x8xf32>}> : () -> tensor<6x4x8xf32>
    %2 = tosa.const_shape  {values = dense<[192, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.reshape %0, %2 : (tensor<8x4x6xi16>, !tosa.shape<2>) -> tensor<192x1xi16>
    %4 = tosa.floor %1 : (tensor<6x4x8xf32>) -> tensor<6x4x8xf32>
    %5 = tosa.concat %3, %3 {axis = 1 : i32} : (tensor<192x1xi16>, tensor<192x1xi16>) -> tensor<192x2xi16>
    %6 = tosa.maximum %4, %4 : (tensor<6x4x8xf32>, tensor<6x4x8xf32>) -> tensor<6x4x8xf32>
    %7 = tosa.identity %4 : (tensor<6x4x8xf32>) -> tensor<6x4x8xf32>
    %8 = tosa.reduce_sum %7 {axis = 2 : i32} : (tensor<6x4x8xf32>) -> tensor<6x4x1xf32>
    %cast = tensor.cast %5 : tensor<192x2xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<6x4x8xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<6x4x1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

